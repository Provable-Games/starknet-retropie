// Core imports

use core::debug::PrintTrait;

// Starknet imports

use starknet::testing::{set_contract_address, set_transaction_hash};

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Internal imports

use retropie::store::{Store, StoreTrait};
use retropie::models::game::{Game, GameTrait};
use retropie::systems::actions::IActionsDispatcherTrait;

// Test imports

use retropie::tests::setup::{setup, setup::Systems};

#[test]
fn test_actions_register() {
    // [Setup]
    let (world, _, context) = setup::spawn_game();
    let store = StoreTrait::new(world);

    // [Assert]
    let game = store.game(context.game_id);
    assert(game.id == context.game_id, 'Game: id');
    assert(game.short_name == context.game_short_name, 'Game: short_name');
    assert(game.full_name == context.game_full_name, 'Game: full_name');
    assert(game.rom_path == context.game_rom_path, 'Game: rom_path');
    assert(game.owner == context.owner, 'Game: owner');
}
