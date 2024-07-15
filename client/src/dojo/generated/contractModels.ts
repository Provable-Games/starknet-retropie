/* Autogenerated file. Do not edit manually. */

import { defineComponent, Type as RecsType, World } from "@dojoengine/recs";

export type ContractComponents = Awaited<
  ReturnType<typeof defineContractComponents>
>;

export function defineContractComponents(world: World) {
  return {
    Game: (() => {
      return defineComponent(
        world,
        {
          id: RecsType.BigInt,
          name: RecsType.BigInt,
          desc: RecsType.String,
          image: RecsType.String,
          rating: RecsType.Number,
          releasedate: RecsType.BigInt,
          developer: RecsType.BigInt,
          publisher: RecsType.BigInt,
          genre: RecsType.BigInt,
          players: RecsType.Number,
          playcount: RecsType.Number,
          lastplayed: RecsType.BigInt,
          owner: RecsType.BigInt,
        },
        {
          metadata: {
            name: "Game",
            types: [
              "u64",
              "felt252",
              "u8",
              "u64",
              "felt252",
              "felt252",
              "felt252",
              "u8",
              "u32",
              "u64",
              "felt252",
            ],
            customTypes: [],
          },
        },
      );
    })(),
  };
}
