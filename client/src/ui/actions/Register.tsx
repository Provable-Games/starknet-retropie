import { useDojo } from "@/dojo/useDojo";
import { useCallback, useMemo, useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogClose,
} from "@/ui/elements/dialog";
import { Button } from "@/ui/elements/button";
import { Input } from "@/ui/elements/input";
import { MAX_CHAR_VALUE } from "../constants";

export const Register = () => {
  const [shortName, setShortName] = useState("");
  const [fullName, setFullName] = useState("");
  const [romPath, setRomPath] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const {
    account: { account },
    master,
    setup: {
      systemCalls: { register },
    },
  } = useDojo();

  const handleClick = useCallback(async () => {
    setIsLoading(true);
    try {
      await register({ account: account, shortName, fullName, romPath });
    } finally {
      setIsLoading(false);
    }
  }, [account, shortName, fullName, romPath]);

  const disabled = useMemo(() => {
    return !account || !master || account === master;
  }, [account, master]);

  if (disabled) return null;

  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button disabled={disabled}>Register</Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Register a game</DialogTitle>
          <DialogDescription>Provide the game data</DialogDescription>
        </DialogHeader>

        <Input
          className="w-full"
          placeholder="Short name"
          type="text"
          value={shortName}
          onChange={(e) => {
            if (e.target.value.length <= MAX_CHAR_VALUE) {
              setShortName(e.target.value);
            }
          }}
        />

        <Input
          className="w-full"
          placeholder="This is a long name"
          type="text"
          value={fullName}
          onChange={(e) => {
            if (e.target.value.length <= MAX_CHAR_VALUE) {
              setFullName(e.target.value);
            }
          }}
        />

        <Input
          className="w-full"
          placeholder="Rom path"
          type="text"
          value={romPath}
          onChange={(e) => {
            if (e.target.value.length <= MAX_CHAR_VALUE) {
              setRomPath(e.target.value);
            }
          }}
        />

        <DialogClose asChild>
          <Button
            disabled={!shortName || !fullName || !romPath}
            isLoading={isLoading}
            onClick={handleClick}
          >
            Register
          </Button>
        </DialogClose>
      </DialogContent>
    </Dialog>
  );
};
