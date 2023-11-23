export default function Project({
  params,
}: {
  params: {
    projectid: string;
  };
}) {
  const projectid = params.projectid;
  return (
    <>
      <div className="h-screen w-full flex justify-center items-center">
        <h1>Project Page for ProjectID #{projectid}</h1>
      </div>
    </>
  );
}
