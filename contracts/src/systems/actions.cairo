// Starknet imports

use starknet::ContractAddress;

// Dojo imports

use dojo::world::IWorldDispatcher;

// Interfaces

#[starknet::interface]
trait IActions<TContractState> {
    fn register(
        self: @TContractState,
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
    ) -> u64;
    fn update(
        self: @TContractState,
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
    );
}

// Contracts

#[starknet::contract]
mod actions {
    // Dojo imports

    use dojo::world;
    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;
    use dojo::world::IDojoResourceProvider;

    // Component imports

    use retropie::components::initializable::InitializableComponent;
    use retropie::components::registerable::RegisterableComponent;

    // Local imports

    use super::IActions;

    // Components

    component!(path: InitializableComponent, storage: initializable, event: InitializableEvent);
    #[abi(embed_v0)]
    impl WorldProviderImpl =
        InitializableComponent::WorldProviderImpl<ContractState>;
    #[abi(embed_v0)]
    impl DojoInitImpl = InitializableComponent::DojoInitImpl<ContractState>;
    component!(path: RegisterableComponent, storage: registerable, event: RegisterableEvent);
    impl RegisterableImpl = RegisterableComponent::InternalImpl<ContractState>;

    // Storage

    #[storage]
    struct Storage {
        #[substorage(v0)]
        initializable: InitializableComponent::Storage,
        #[substorage(v0)]
        registerable: RegisterableComponent::Storage,
    }

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        InitializableEvent: InitializableComponent::Event,
        #[flat]
        RegisterableEvent: RegisterableComponent::Event,
    }

    // Implementations

    #[abi(embed_v0)]
    impl DojoResourceProviderImpl of IDojoResourceProvider<ContractState> {
        fn dojo_resource(self: @ContractState) -> felt252 {
            'actions'
        }
    }

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn register(
            self: @ContractState,
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
            self
                .registerable
                .register(
                    world,
                    name,
                    desc,
                    image,
                    rating,
                    releasedate,
                    developer,
                    publisher,
                    genre,
                    players,
                    lastplayed
                )
        }

        fn update(
            self: @ContractState,
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
            self
                .registerable
                .update(
                    world,
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
                    lastplayed
                )
        }
    }
}
