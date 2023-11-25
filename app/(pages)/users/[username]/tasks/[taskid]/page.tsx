import { sql } from "@vercel/postgres";
import { notFound } from "next/navigation";
import Link from "next/link";

async function fetchTaskAssociatesByTask(taskid: string) {
  // console.log(taskid);
  try {
    const data = await sql`
    SELECT * FROM TaskAssociates
    JOIN Tasks ON TaskAssociates.task_id = Tasks.task_id
    JOIN Associates ON TaskAssociates.associate_id = Associates.associate_id
    JOIN Projects ON Tasks.project_id = Projects.project_id
    JOIN Users ON Projects.user_id = Users.user_id
    WHERE Tasks.task_id=${taskid}
    LIMIT 5;
    `;
    // console.log(data);
    return data.rows;
  } catch (error) {
    console.error("Database Error:", error);
    throw new Error("Failed to user projects data.");
  }
}

export default async function Task({
  params,
}: {
  params: {
    username: string;
    taskid: string;
  };
}) {
  const taskid = params.taskid;
  const username = params.username;
  const { rows } = await sql`
    SELECT * FROM Tasks 
    JOIN Projects ON Tasks.project_id = Projects.project_id
    JOIN Categories ON Tasks.category_id = Categories.category_id
    JOIN Users ON Projects.user_id = Users.user_id 
    WHERE Users.user_username=${username}
    AND Tasks.task_id=${taskid}
    LIMIT 1;
  `;

  const taskTaskAssociates = await fetchTaskAssociatesByTask(taskid);
  // console.log(taskTaskAssociates);

  if (!rows[0]) {
    notFound();
  }

  return (
    <>
      <div className="min-h-screen p-8 w-full flex justify-center items-center">
        <div className="text-center max-w-prose">
          <div>
            <h1>
              {/* Task Page for TaskID #{taskid} of ProjectID #{projectid} */}
              Task Page for TaskID #{rows[0].task_id} of ProjectID #
              {rows[0].project_id}
            </h1>
            <p className="pt-2 font-semibold">{rows[0].task_name}</p>
            <p className="pt-2">{rows[0].task_state}</p>
            <p className="pt-2">{rows[0].category_name}</p>
            <Link
              href={`/users/${username}/projects/${rows[0].project_id}`}
              className="underline inline-block pt-2"
            >
              {rows[0].project_name}
            </Link>
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
            À partir de la page de tâche et de requêtes sur la table
            TaskAssociates, il sera possible de retrouver par tâche toutes les
            personnes légales (compagnies, amis, famille) travaillant sur cette
            tâche.
          </p>
          {taskTaskAssociates && (
            <ol className="pt-4 space-y-2">
              {taskTaskAssociates.map((taskTaskAssociate) => {
                return (
                  <li key={taskTaskAssociate.taskassociate_id}>
                    <p>{taskTaskAssociate.associate_app_wide_name}</p>
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

// Keeping the double dynamics for now but I can find the info on the project directly from the task so it's not something worth keeping. (Update: projectid removed from URL.)
