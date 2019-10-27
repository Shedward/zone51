pub struct Table {
    index: u8
}

pub struct ServingHall {
    tables_count: u8,
    taken_tables: Vec<u8>
}

impl ServingHall {
    pub fn new(count: u8) -> ServingHall {
        ServingHall {
            tables_count: count,
            taken_tables: Vec::new()
        }
    }

    pub fn take_table(&mut self) -> Option<Table> {
        (0..u8::max_value()).find(|i| !self.taken_tables.contains(i)).map(|index| {
            self.taken_tables.push(index);
            Table {
                index: index
            }
        })
    }
}