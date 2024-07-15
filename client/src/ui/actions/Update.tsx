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
  const [name, setName] = useState(game.name);
  const [description, setDescription] = useState(game.description);
  const [image, setImage] = useState(game.image);
  const [rating, setRating] = useState(game.rating);
  const [releaseDate, setReleaseDate] = useState(game.releaseDate);
  const [developer, setDeveloper] = useState(game.developer);
  const [publisher, setPublisher] = useState(game.publisher);
  const [genre, setGenre] = useState(game.genre);
  const [players, setPlayers] = useState(game.players);
  const [lastPlayed, setLastPlayed] = useState(game.lastPlayed);
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
      await update({
        account: account,
        gameId,
        name,
        description,
        image,
        rating,
        releaseDate,
        developer,
        publisher,
        genre,
        players,
        lastPlayed,
      });
    } finally {
      setIsLoading(false);
    }
  }, [
    account,
    gameId,
    name,
    description,
    image,
    rating,
    releaseDate,
    developer,
    publisher,
    genre,
    players,
    lastPlayed,
    update,
  ]);

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
          placeholder="Name"
          type="text"
          value={name}
          onChange={(e) => {
            if (e.target.value.length <= MAX_CHAR_VALUE) {
              setName(e.target.value);
            }
          }}
        />

        <Input
          className="w-full"
          placeholder="Description"
          type="text"
          value={description}
          onChange={(e) => {
            setDescription(e.target.value);
          }}
        />

        <Input
          className="w-full"
          placeholder="Image"
          type="text"
          value={image}
          onChange={(e) => {
            setImage(e.target.value);
          }}
        />

        <Input
          className="w-full"
          placeholder="Rating"
          type="number"
          value={rating}
          onChange={(e) => {
            setRating(parseInt(e.target.value));
          }}
        />

        <Input
          className="w-full"
          placeholder="Release Date"
          type="number"
          value={releaseDate}
          onChange={(e) => {
            setReleaseDate(parseInt(e.target.value));
          }}
        />

        <Input
          className="w-full"
          placeholder="Developer"
          type="text"
          value={developer}
          onChange={(e) => {
            if (e.target.value.length <= MAX_CHAR_VALUE) {
              setDeveloper(e.target.value);
            }
          }}
        />

        <Input
          className="w-full"
          placeholder="Publisher"
          type="text"
          value={publisher}
          onChange={(e) => {
            if (e.target.value.length <= MAX_CHAR_VALUE) {
              setPublisher(e.target.value);
            }
          }}
        />

        <Input
          className="w-full"
          placeholder="Genre"
          type="text"
          value={genre}
          onChange={(e) => {
            if (e.target.value.length <= MAX_CHAR_VALUE) {
              setGenre(e.target.value);
            }
          }}
        />

        <Input
          className="w-full"
          placeholder="Players"
          type="number"
          value={players}
          onChange={(e) => {
            setPlayers(parseInt(e.target.value));
          }}
        />

        <Input
          className="w-full"
          placeholder="Last Played"
          type="number"
          value={lastPlayed}
          onChange={(e) => {
            setLastPlayed(parseInt(e.target.value));
          }}
        />

        <DialogClose asChild>
          <Button
            disabled={
              !name ||
              !description ||
              !image ||
              !rating ||
              !releaseDate ||
              !developer ||
              !publisher ||
              !genre ||
              !players ||
              !lastPlayed
            }
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
