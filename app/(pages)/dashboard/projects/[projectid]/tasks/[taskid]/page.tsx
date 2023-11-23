export default function Task({
  params,
}: {
  params: {
    taskid: string;
    projectid: string;
  };
}) {
  const taskid = params.taskid;
  const projectid = params.projectid;
  return (
    <>
      <div className="h-screen w-full flex justify-center items-center">
        <h1>
          Task Page for TaskID #{taskid} of ProjectID #{projectid}
        </h1>
      </div>
    </>
  );
}
