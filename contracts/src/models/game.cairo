// Internal imports

use retropie::models::index::Game;

// Errors

mod errors {
    const GAME_INVALID_INPUT: felt252 = 'Game: invaid input';
    const GAME_INVALID_OWNER: felt252 = 'Game: invalid owner';
    const GAME_DOES_NOT_EXIST: felt252 = 'Game: does not exist';
}


#[generate_trait]
impl GameImpl of GameTrait {
    #[inline(always)]
    fn new(
        id: u32, short_name: felt252, full_name: felt252, rom_path: felt252, owner: felt252
    ) -> Game {
        // [Check] Inputs
        GameAssert::assert_is_valid(short_name);
        GameAssert::assert_is_valid(full_name);
        GameAssert::assert_is_valid(rom_path);
        GameAssert::assert_is_valid(owner);
        // [Effect] Create game
        Game { id, short_name, full_name, rom_path, owner, }
    }

    #[inline(always)]
    fn update(ref self: Game, short_name: felt252, full_name: felt252, rom_path: felt252) {
        // [Check] Inputs
        GameAssert::assert_is_valid(short_name);
        GameAssert::assert_is_valid(full_name);
        GameAssert::assert_is_valid(rom_path);
        // [Effect] Update game
        self.short_name = short_name;
        self.full_name = full_name;
        self.rom_path = rom_path;
    }
}

#[generate_trait]
impl GameAssert of AssertTrait {
    #[inline(always)]
    fn assert_is_valid(name: felt252) {
        assert(name != 0, errors::GAME_INVALID_INPUT);
    }

    #[inline(always)]
    fn assert_is_owner(self: Game, owner: felt252) {
        assert(self.owner == owner, errors::GAME_INVALID_OWNER);
    }

    #[inline(always)]
    fn assert_exists(self: Game) {
        assert(self.is_non_zero(), errors::GAME_DOES_NOT_EXIST);
    }
}

impl GameZeroable of core::zeroable::Zeroable<Game> {
    #[inline(always)]
    fn zero() -> Game {
        Game { id: 0, short_name: 0, full_name: 0, rom_path: 0, owner: 0, }
    }

    #[inline(always)]
    fn is_zero(self: Game) -> bool {
        self.owner == 0
    }

    #[inline(always)]
    fn is_non_zero(self: Game) -> bool {
        self.owner != 0
    }
}
