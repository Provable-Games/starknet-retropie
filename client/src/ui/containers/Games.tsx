import { useGames } from "@/hooks/useGames";
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/ui/elements/table";
import { Update } from "../actions/Update";

export const Games = () => {
  const { games } = useGames();

  if (!games.length) return null;

  return (
    <div className="mx-auto">
      <Table>
        <TableCaption>Games</TableCaption>
        <TableHeader>
          <TableRow>
            <TableHead className="w-[100px]">#</TableHead>
            <TableHead>Short Name</TableHead>
            <TableHead>Full Name</TableHead>
            <TableHead>ROM Path</TableHead>
            <TableHead> </TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {games.map((game) => (
            <TableRow key={game.id}>
              <TableCell>{game.id}</TableCell>
              <TableCell>{game.shortName}</TableCell>
              <TableCell>{game.fullName}</TableCell>
              <TableCell>{game.romPath}</TableCell>
              <TableCell>
                <Update game={game} />
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
};
