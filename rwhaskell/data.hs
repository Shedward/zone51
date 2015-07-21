
type CardHolder = String
type CardNumber = String
type Address = [String]

data BillingInfo = CreditCard  { 
					cardNumber :: CardNumber, 
					cardHolder :: CardHolder,
					address    :: Address 
				   }
				 | CashOnDelivery
				 | Invoice  { cardNumber :: CardNumber }
				   deriving (Show)


main :: IO ()
main = putStrLn (cardNumber card)
	where card = CreditCard "112522" "MaltsevVN" []