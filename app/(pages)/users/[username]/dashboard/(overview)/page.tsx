import { sql } from "@vercel/postgres";
import { notFound } from "next/navigation";

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
  `;

  if (!rows[0]) {
    notFound();
  }

  return (
    <>
      <div className="h-screen w-full flex justify-center items-center">
        <div className="text-center">
          {/* <h1>Dashboard Page</h1> */}
          <h1>Dashboard Page for User {rows[0].user_username}</h1>
          <p className="pt-2">{rows[0].user_app_wide_name}</p>
          <p className="pt-2">{rows[0].user_full_name}</p>
          <p className="pt-2">{rows[0].user_username}</p>
        </div>
      </div>
    </>
  );
}
