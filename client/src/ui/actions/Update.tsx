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
import { Game } from "@/dojo/game/models/game";

export const Update = ({ game }: { game: Game }) => {
  const [shortName, setShortName] = useState(game.shortName);
  const [fullName, setFullName] = useState(game.fullName);
  const [romPath, setRomPath] = useState(game.romPath);
  const [isLoading, setIsLoading] = useState(false);

  const gameId = useMemo(() => game.id, [game]);

  const {
    account: { account },
    master,
    setup: {
      systemCalls: { update },
    },
  } = useDojo();

  const handleClick = useCallback(async () => {
    setIsLoading(true);
    try {
      await update({ account: account, gameId, shortName, fullName, romPath });
    } finally {
      setIsLoading(false);
    }
  }, [account, gameId, shortName, fullName, romPath]);

  const disabled = useMemo(() => {
    return !account || !master || account === master;
  }, [account, master]);

  if (disabled) return null;

  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button disabled={disabled}>Update</Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Update the game</DialogTitle>
          <DialogDescription>Provide the new game data</DialogDescription>
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
          placeholder="Full name"
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
            Update
          </Button>
        </DialogClose>
      </DialogContent>
    </Dialog>
  );
};
