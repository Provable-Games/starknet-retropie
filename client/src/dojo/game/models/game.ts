import { ComponentValue } from "@dojoengine/recs";
import { shortString } from "starknet";

export class Game {
  public id: number;
  public name: string;
  public description: string;
  public image: string;
  public rating: number;
  public releaseDate: number;
  public developer: string;
  public publisher: string;
  public genre: string;
  public players: number;
  public lastPlayed: number;

  constructor(game: ComponentValue) {
    this.id = game.id;
    this.name = shortString.decodeShortString(game.name);
    this.description = game.desc;
    this.image = game.image;
    this.rating = game.rating;
    this.releaseDate = game.releasedate;
    this.developer = shortString.decodeShortString(game.developer);
    this.publisher = shortString.decodeShortString(game.publisher);
    this.genre = shortString.decodeShortString(game.genre);
    this.players = game.players;
    this.lastPlayed = game.lastplayed;
  }
}
