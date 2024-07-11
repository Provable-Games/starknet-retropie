import { useCallback } from "react";
import { Account } from "@/ui/components/Account";
import { Separator } from "@/ui/elements/separator";
import { useNavigate } from "react-router-dom";
import { ModeToggle } from "@/ui/components/Theme";

export const Header = () => {
  const navigate = useNavigate();

  const handleClick = useCallback(() => {
    navigate("", { replace: true });
  }, [navigate]);

  return (
    <div>
      <div className="flex justify-center items-center p-4 flex-wrap md:justify-between">
        <div
          className="cursor-pointer flex gap-8 items-center"
          onClick={handleClick}
        >
          <p className="text-4xl font-bold">RetroPie</p>
        </div>
        <div className="flex flex-col gap-4 items-center md:flex-row">
          <div className="flex gap-2">
            <Account />
            <ModeToggle />
          </div>
        </div>
      </div>
      <Separator />
    </div>
  );
};
