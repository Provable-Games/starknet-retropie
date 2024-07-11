import loader from "/assets/loader.svg";

export const Loading = () => {
  return (
    <div className="w-full h-screen flex justify-center items-center">
      {/* Loader */}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 flex justify-center items-center w-full h-20">
        <img src={loader} alt="loader" className={`h-32 md:h-40`} />
      </div>
    </div>
  );
};
