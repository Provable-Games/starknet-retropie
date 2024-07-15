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
            name: felt252,
            desc: ByteArray,
            image: ByteArray,
            rating: u8,
            releasedate: u64,
            developer: felt252,
            publisher: felt252,
            genre: felt252,
            players: u8,
            lastplayed: u64,
        ) -> u64 {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Effect] Create game
            let owner: felt252 = get_caller_address().into();
            let game_id: u64 = world.uuid().into() + 1;
            let game = GameTrait::new(
                game_id,
                name,
                desc,
                image,
                rating,
                releasedate,
                developer,
                publisher,
                genre,
                players,
                lastplayed,
                owner
            );
            store.set_game(game);

            // [Return] Game id
            game_id
        }

        fn update(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            game_id: u64,
            name: felt252,
            desc: ByteArray,
            image: ByteArray,
            rating: u8,
            releasedate: u64,
            developer: felt252,
            publisher: felt252,
            genre: felt252,
            players: u8,
            lastplayed: u64,
        ) {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Game exists
            let mut game = store.game(game_id);
            game.clone().assert_exists();

            // [Check] Caller is the owner
            let caller: felt252 = get_caller_address().into();
            game.clone().assert_is_owner(caller);

            // [Effect] Update game
            game
                .update(
                    name,
                    desc: desc.clone(),
                    image: image.clone(),
                    rating: rating,
                    releasedate: releasedate,
                    developer: developer,
                    publisher: publisher,
                    genre: genre,
                    players: players,
                    lastplayed: lastplayed
                );
            store.set_game(game);
        }
    }
}
