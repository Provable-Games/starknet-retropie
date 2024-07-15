//! Store struct and component management methods.

// Core imports

use core::debug::PrintTrait;

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Models imports

use retropie::models::game::{Game, GameTrait};

/// Store struct.
#[derive(Copy, Drop)]
struct Store {
    world: IWorldDispatcher,
}

/// Implementation of the `StoreTrait` trait for the `Store` struct.
#[generate_trait]
impl StoreImpl of StoreTrait {
    #[inline(always)]
    fn new(world: IWorldDispatcher) -> Store {
        Store { world: world }
    }
    #[inline(always)]
    fn game(self: Store, game_id: u64) -> Game {
        get!(self.world, game_id, (Game))
    }

    #[inline(always)]
    fn set_game(self: Store, game: Game) {
        set!(self.world, (game))
    }
}
