import { sql } from "@vercel/postgres";
import { notFound } from "next/navigation";

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
    JOIN users ON projects.user_id = users.user_id 
    WHERE users.user_username=${username}
    AND projects.project_id=${projectid}
  `;

  if (!rows[0]) {
    notFound();
  }

  return (
    <>
      <div className="h-screen w-full flex justify-center items-center">
        <div className="text-center">
          {/* <h1>Project Page for ProjectID #{projectid}</h1> */}
          <h1>Project Page for ProjectID #{rows[0].project_id}</h1>
          <p className="pt-2">{rows[0].project_name}</p>
          <p className="pt-2">{rows[0].project_state}</p>
          <p className="pt-2">{rows[0].user_app_wide_name}</p>
          <p className="pt-2">{rows[0].user_full_name}</p>
          <p className="pt-2">{rows[0].user_username}</p>
        </div>
      </div>
    </>
  );
}
