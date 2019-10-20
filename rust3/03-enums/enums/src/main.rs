use std::slice::Iter;
use std::iter::FromIterator;
use std::io;

#[derive(Debug, Clone, Copy)]
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter
}

impl Coin {
    fn iter() -> Iter<'static, Coin> {
        static COINS: [Coin; 4] = [
            Coin::Penny, 
            Coin::Nickel,
            Coin::Dime,
            Coin::Quarter
        ];
        COINS.into_iter()
    }

    fn value(&self) -> u8 {
        match self {
            Coin::Penny => 1,
            Coin::Nickel => 5,
            Coin::Dime => 10,
            Coin::Quarter => 25
        }
    }
}

#[derive(Debug)]
struct CoinsBag {
    coins: Vec<Coin>
}

impl CoinsBag {
    fn total(&self) -> u32 {
        self.coins.iter().fold(0, |total, coin| total + coin.value() as u32 )
    }
}

struct Banker {
}

impl Banker {
    fn new() -> Banker {
        Banker { }
    }
    fn get_change(&mut self, amount: u32) -> CoinsBag {
        let mut left_amount = amount;
        let mut coins = Vec::new();
        let mut ordered_coins = Vec::from_iter(Coin::iter());
        ordered_coins.sort_by(|l, r| r.value().cmp(&l.value()));
        while left_amount > 0 {
            if let Some(&&max_coin) = ordered_coins.iter().find(|&c| c.value() as u32 <= left_amount ) {
                left_amount -= max_coin.value() as u32;
                coins.push(max_coin);
            }
        }
        CoinsBag { coins: coins }
    }
}

fn main() {
    let mut banker = Banker::new();
    let mut input = String::new();
    while io::stdin().read_line(&mut input).is_ok() {
        if input.trim().is_empty() {
            break;
        }
        match input.trim().parse::<u32>() {
            Ok(number) => {
                if number == 0 {
                    println!("Exit");
                    return;
                } else {
                    let coins = banker.get_change(number);
                    println!("Change {:?} with total {:?}", coins, coins.total());
                }
            },
            Err(error) => {
                println!("Only numbers supported: {:?}, {:?}", input, error);
            }
        }
        input.clear();
    }
}
