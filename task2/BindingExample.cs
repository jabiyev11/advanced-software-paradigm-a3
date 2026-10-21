using System;

class Payment
{
    public virtual void Process()
    {
        Console.WriteLine("Processing generic payment");
    }

    public void PrintReceipt()
    {
        Console.WriteLine("Receipt: payment");
    }
}

class CardPayment : Payment
{
    public override void Process()
    {
        Console.WriteLine("Charging card");
    }

    public new void PrintReceipt()
    {
        Console.WriteLine("Receipt: card payment");
    }
}

class CashPayment : Payment
{
    public new void Process()
    {
        Console.WriteLine("Accepting cash");
    }
}

class Program
{
    static void Main()
    {
        Payment paymentCard = new CardPayment();
        CardPayment card = new CardPayment();
        Payment paymentCash = new CashPayment();
        CashPayment cash = new CashPayment();

        Console.WriteLine("--- Dynamic binding (virtual + override) ---");
        paymentCard.Process();      // Charging card, chosen by the real object type
        card.Process();             // Charging card

        Console.WriteLine("\n--- Static binding (new on non-virtual) ---");
        paymentCard.PrintReceipt(); // Receipt: payment, chosen by the declared type
        card.PrintReceipt();        // Receipt: card payment

        Console.WriteLine("\n--- Static binding (new on virtual) ---");
        paymentCash.Process();      // Processing generic payment, CashPayment's version is hidden
        cash.Process();             // Accepting cash
    }
}