
#[derive(Debug)]
pub enum Separator {
    StringSeparator(String),
    Whitespace
}

#[derive(Debug)]
pub enum Grouping {
    Column { index: u32, separator: Separator },
    Regex(String)
}

#[derive(Debug)]
pub struct Options {
    grouping: Grouping
}

/// Parse command-line arguments to grouping options.
/// Posible formats:
/// groupby column 2 -s ':'  - by 2 column separated by :
///                  -w      - by 2 column separated by any whitespace
///
/// groupby regex '^[0-9]* ' - by regex
///
impl Options {
    pub fn new(args: &Vec<String>) -> Result<Options, &'static str> {
        let grouping_type = args.get(1).ok_or("no type")?;

        let grouping: Grouping;

        match grouping_type.as_ref() {
            "column" => {
                let column_index_string = args.get(2).ok_or("no column index")?;
                let column_index = column_index_string.parse::<u32>().map_err(|_| "wrong column index")?;

                let separator_type = args.get(3).map(String::as_ref);
                let separator = match (separator_type, args.get(4)) {
                    ( Some("-s"), Some(string) ) => { Separator::StringSeparator(string.clone()) },
                    _                            => { Separator::Whitespace }
                };

                grouping = Grouping::Column { index: column_index, separator: separator };
            },

            "regex" => {
                let regex = args.get(2).ok_or("no regex")?;

                grouping = Grouping::Regex(regex.clone());
            },

            _ => {
                return Err("wrong grouping type")
            }
        };

        Ok(Options {
            grouping: grouping
        })
    }
}