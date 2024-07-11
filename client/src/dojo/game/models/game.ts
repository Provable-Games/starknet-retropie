import { ComponentValue } from "@dojoengine/recs";
import { shortString } from "starknet";

export class Game {
  public id: number;
  public shortName: string;
  public fullName: string;
  public romPath: string;

  constructor(game: ComponentValue) {
    this.id = game.id;
    this.shortName = shortString.decodeShortString(game.short_name);
    this.fullName = shortString.decodeShortString(game.full_name);
    this.romPath = shortString.decodeShortString(game.rom_path);
  }
}
