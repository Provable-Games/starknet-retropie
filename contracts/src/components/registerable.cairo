//! Manageable component

#[starknet::component]
mod RegisterableComponent {
    // Starknet imports

    use retropie::store::StoreTrait;
    use starknet::ContractAddress;
    use starknet::info::get_caller_address;

    // Dojo imports

    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;

    // Internal imports

    use retropie::store::{Store, StoreImpl};
    use retropie::models::game::{Game, GameTrait, GameAssert};

    // Storage

    #[storage]
    struct Storage {}

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        fn register(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            short_name: felt252,
            full_name: felt252,
            rom_path: felt252,
        ) -> u32 {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Effect] Create game
            let owner: felt252 = get_caller_address().into();
            let game_id: u32 = world.uuid() + 1;
            let game = GameTrait::new(game_id, short_name, full_name, rom_path, owner);
            store.set_game(game);

            // [Return] Game id
            game_id
        }

        fn update(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            game_id: u32,
            short_name: felt252,
            full_name: felt252,
            rom_path: felt252,
        ) {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Game exists
            let mut game = store.game(game_id);
            game.assert_exists();

            // [Check] Caller is the owner
            let caller: felt252 = get_caller_address().into();
            game.assert_is_owner(caller);

            // [Effect] Update game
            game.update(short_name, full_name, rom_path);
            store.set_game(game);
        }
    }
}
