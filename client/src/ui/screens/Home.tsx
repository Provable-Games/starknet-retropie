import { Header } from "@/ui/containers/Header";
import { Games } from "../containers/Games";
import { Actions } from "../containers/Actions";

export const Home = () => {
  return (
    <div className="relative flex flex-col h-screen gap-4 p-4">
      <Header />
      <Actions />
      <Games />
    </div>
  );
};
