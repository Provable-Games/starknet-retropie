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
          id: RecsType.Number,
          short_name: RecsType.BigInt,
          full_name: RecsType.BigInt,
          rom_path: RecsType.BigInt,
          owner: RecsType.BigInt,
        },
        {
          metadata: {
            name: "Game",
            types: ["u32", "felt252", "felt252", "felt252", "felt252"],
            customTypes: [],
          },
        },
      );
    })(),
  };
}
