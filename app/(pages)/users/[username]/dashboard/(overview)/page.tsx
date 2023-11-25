import { sql } from "@vercel/postgres";
import { notFound } from "next/navigation";
import Link from "next/link";

async function fetchProjectByUser(username: string) {
  // console.log(username);
  try {
    const data = await sql`
      SELECT * FROM Projects
      JOIN Users ON Projects.user_id = Users.user_id
      WHERE Users.user_username=${username}
    `;
    // console.log(data);
    return data.rows;
  } catch (error) {
    console.error("Database Error:", error);
    throw new Error("Failed to user projects data.");
  }
}

export default async function Dashboard({
  params,
}: {
  params: {
    username: string;
  };
}) {
  const username = params.username;

  const { rows } = await sql`
    SELECT * FROM Users 
    WHERE user_username=${username}
    LIMIT 1;
  `;

  const userProjects = await fetchProjectByUser(username);
  // console.log(userProjects);

  if (!rows[0]) {
    notFound();
  }

  return (
    <>
      <div className="min-h-screen p-8 w-full flex justify-center items-center">
        <div className="text-center max-w-prose">
          {/* <h1>Dashboard Page</h1> */}
          <div>
            <h1>Dashboard Page for User {rows[0].user_username}</h1>
            <p className="pt-2">{rows[0].user_app_wide_name}</p>
            <p className="pt-2">{rows[0].user_full_name}</p>
            <p className="pt-2">{rows[0].user_username}</p>
          </div>
          <p className="pt-4">
            Par mesure première et de simplicité, tous les projets de
            l&rsquo;utilisateur seront accessibles depuis sa page.
          </p>
          <ol className="pt-4 space-y-2">
            {userProjects.map((userProject) => {
              return (
                <li key={userProject.project_id}>
                  <Link
                    className="underline"
                    href={`/users/${userProject.user_username}/projects/${userProject.project_id}`}
                  >
                    <p>{userProject.project_name}</p>
                  </Link>
                </li>
              );
            })}
          </ol>
        </div>
      </div>
    </>
  );
}
