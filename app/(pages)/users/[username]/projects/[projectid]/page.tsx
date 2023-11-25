import { sql } from "@vercel/postgres";
import { notFound } from "next/navigation";
import Link from "next/link";

async function fetchTasksByProject(username: string, projectid: string) {
  // console.log(username);
  // console.log(projectid);
  try {
    const data = await sql`
      SELECT * FROM Tasks
      JOIN Projects ON Tasks.project_id = Projects.project_id
      JOIN Categories ON Tasks.category_id = Categories.category_id
      JOIN Users ON Projects.user_id = Users.user_id
      WHERE Users.user_username=${username} 
      AND Projects.project_id=${projectid}
      LIMIT 5;
    `;
    // console.log(data);
    return data.rows;
  } catch (error) {
    console.error("Database Error:", error);
    throw new Error("Failed to user projects data.");
  }
}

export default async function Project({
  params,
}: {
  params: {
    username: string;
    projectid: string;
  };
}) {
  const username = params.username;
  const projectid = params.projectid;

  const { rows } = await sql`
    SELECT * FROM Projects
    JOIN Users ON Projects.user_id = Users.user_id 
    WHERE Users.user_username=${username}
    AND Projects.project_id=${projectid}
    LIMIT 1;
  `;

  const projectTasks = await fetchTasksByProject(username, projectid);
  // console.log(projectTasks);

  if (!rows[0]) {
    notFound();
  }

  return (
    <>
      <div className="min-h-screen p-8 w-full flex justify-center items-center">
        <div className="text-center max-w-prose">
          <div>
            {/* <h1>Project Page for ProjectID #{projectid}</h1> */}
            <h1>Project Page for ProjectID #{rows[0].project_id}</h1>
            <p className="pt-2 font-semibold">{rows[0].project_name}</p>
            <p className="pt-2">{rows[0].project_state}</p>
            <Link
              href={`/users/${username}/dashboard`}
              className="underline inline-block pt-2"
            >
              {rows[0].user_app_wide_name}
            </Link>
            <p className="pt-2">{rows[0].user_full_name}</p>
            <p className="pt-2">{rows[0].user_username}</p>
          </div>
          <p className="pt-4">
            Par mesure première et de simplicité, toutes les tâches du projet
            seront accessibles depuis sa page.
          </p>
          {projectTasks && (
            <ol className="pt-4 space-y-2">
              {projectTasks.map((projectTask) => {
                return (
                  <li key={projectTask.task_id}>
                    <Link
                      className="underline"
                      href={`/users/${projectTask.user_username}/tasks/${projectTask.task_id}`}
                    >
                      <p>{projectTask.task_name}</p>
                    </Link>
                  </li>
                );
              })}
            </ol>
          )}
        </div>
      </div>
    </>
  );
}
