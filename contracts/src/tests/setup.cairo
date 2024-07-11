mod setup {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::testing::{set_contract_address, set_caller_address};

    // Dojo imports

    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use dojo::test_utils::{spawn_test_world, deploy_contract};

    // Internal imports

    use retropie::models::game::{Game, GameTrait};
    use retropie::systems::actions::{
        actions, IActions, IActionsDispatcher, IActionsDispatcherTrait
    };

    // Constants

    fn OWNER() -> ContractAddress {
        starknet::contract_address_const::<'OWNER'>()
    }

    const GAME_SHORT_NAME: felt252 = 'SHORT';
    const GAME_FULL_NAME: felt252 = 'FULL';
    const GAME_ROM_PATH: felt252 = 'PATH';

    #[derive(Drop)]
    struct Systems {
        actions: IActionsDispatcher,
    }

    #[derive(Drop)]
    struct Context {
        owner: felt252,
        game_id: u32,
        game_short_name: felt252,
        game_full_name: felt252,
        game_rom_path: felt252,
    }

    #[inline(always)]
    fn spawn_game() -> (IWorldDispatcher, Systems, Context) {
        // [Setup] World
        let mut models = core::array::ArrayTrait::new();
        models.append(retropie::models::index::game::TEST_CLASS_HASH);
        let world = spawn_test_world(models);

        // [Setup] Systems
        let actions_address = deploy_contract(actions::TEST_CLASS_HASH, array![].span());
        let systems = Systems {
            actions: IActionsDispatcher { contract_address: actions_address },
        };

        // [Setup] Context
        set_contract_address(OWNER());
        let game_id = systems
            .actions
            .register(world, GAME_SHORT_NAME, GAME_FULL_NAME, GAME_ROM_PATH);

        let context = Context {
            owner: OWNER().into(),
            game_id,
            game_short_name: GAME_SHORT_NAME,
            game_full_name: GAME_FULL_NAME,
            game_rom_path: GAME_ROM_PATH,
        };

        // [Return]
        (world, systems, context)
    }
}
