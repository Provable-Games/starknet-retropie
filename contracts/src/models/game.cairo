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
        id: u64,
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
        owner: felt252,
    ) -> Game {
        // [Check] Inputs
        GameAssert::assert_is_valid(name);
        GameAssert::assert_is_valid(developer);
        GameAssert::assert_is_valid(publisher);
        GameAssert::assert_is_valid(genre);
        GameAssert::assert_is_valid(owner);
        // [Effect] Create game
        Game {
            id,
            name,
            desc,
            image,
            rating,
            releasedate,
            developer,
            publisher,
            genre,
            players,
            playcount: 0,
            lastplayed,
            owner
        }
    }

    #[inline(always)]
    fn update(
        ref self: Game,
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
        // [Check] Inputs
        GameAssert::assert_is_valid(name);
        GameAssert::assert_is_valid(developer);
        GameAssert::assert_is_valid(publisher);
        GameAssert::assert_is_valid(genre);
        // [Effect] Update game
        self.name = name;
        self.desc = desc;
        self.image = image;
        self.rating = rating;
        self.releasedate = releasedate;
        self.developer = developer;
        self.publisher = publisher;
        self.genre = genre;
        self.players = players;
        self.lastplayed = lastplayed;
    }
}

#[generate_trait]
impl GameAssert of AssertTrait {
    #[inline(always)]
    fn assert_is_valid(felt: felt252) {
        assert(felt != 0, errors::GAME_INVALID_INPUT);
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
        Game {
            id: 0,
            name: 0,
            desc: "",
            image: "",
            rating: 0,
            releasedate: 0,
            developer: 0,
            publisher: 0,
            genre: 0,
            players: 0,
            playcount: 0,
            lastplayed: 0,
            owner: 0
        }
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
