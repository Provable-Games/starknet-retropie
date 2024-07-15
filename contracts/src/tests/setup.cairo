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

    const GAME_NAME: felt252 = 'NAME';
    const GAME_RATING: u8 = 50;
    const GAME_RELEASE_DATE: u64 = 2022;
    const GAME_DEVELOPER: felt252 = 'DEVELOPER';
    const GAME_PUBLISHER: felt252 = 'PUBLISHER';
    const GAME_GENRE: felt252 = 'GENRE';
    const GAME_PLAYERS: u8 = 2;
    const GAME_LAST_PLAYED: u64 = 2023;

    #[derive(Drop)]
    struct Systems {
        actions: IActionsDispatcher,
    }

    #[derive(Drop)]
    struct Context {
        owner: felt252,
        game_id: u64,
        game_name: felt252,
        game_description: ByteArray,
        game_image: ByteArray,
        game_rating: u8,
        game_release_date: u64,
        game_developer: felt252,
        game_publisher: felt252,
        game_genre: felt252,
        game_players: u8,
        game_last_played: u64,
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
        let game_description: ByteArray = "DESCRIPTION";
        let game_image: ByteArray = "IMAGE";
        let game_id = systems
            .actions
            .register(
                world,
                GAME_NAME,
                game_description.clone(),
                game_image.clone(),
                GAME_RATING,
                GAME_RELEASE_DATE,
                GAME_DEVELOPER,
                GAME_PUBLISHER,
                GAME_GENRE,
                GAME_PLAYERS,
                GAME_LAST_PLAYED
            );

        let context = Context {
            owner: OWNER().into(),
            game_id,
            game_name: GAME_NAME,
            game_description: game_description,
            game_image: game_image,
            game_rating: GAME_RATING,
            game_release_date: GAME_RELEASE_DATE,
            game_developer: GAME_DEVELOPER,
            game_publisher: GAME_PUBLISHER,
            game_genre: GAME_GENRE,
            game_players: GAME_PLAYERS,
            game_last_played: GAME_LAST_PLAYED,
        };

        // [Return]
        (world, systems, context)
    }
}
