import { sql } from "@vercel/postgres";
import { notFound } from "next/navigation";

export default async function Task({
  params,
}: {
  params: {
    taskid: string;
    projectid: string;
  };
}) {
  const taskid = params.taskid;
  const projectid = params.projectid;
  const { rows } = await sql`
    SELECT * FROM Tasks 
    JOIN projects ON tasks.project_id = projects.project_id
    JOIN categories ON tasks.category_id = categories.category_id
    JOIN users ON projects.user_id = users.user_id 
    WHERE tasks.task_id=${taskid}
    AND tasks.project_id=${projectid};
  `;

  if (!rows[0]) {
    notFound();
  }

  return (
    <>
      <div className="h-screen w-full flex justify-center items-center">
        <div className="text-center">
          <h1>
            {/* Task Page for TaskID #{taskid} of ProjectID #{projectid} */}
            Task Page for TaskID #{rows[0].task_id} of ProjectID #
            {rows[0].project_id}
          </h1>
          <p className="pt-2">{rows[0].task_name}</p>
          <p className="pt-2">{rows[0].project_name}</p>
        </div>
      </div>
    </>
  );
}

// Keeping the double dynamics for now but I can find the info on the project directly from the task so it's not something worth keeping.
