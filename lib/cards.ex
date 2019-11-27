defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings for a deck of cards
  """
  def create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Return a deck that is shuffled
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Example

    iex> deck = Cards.create_deck
    iex> Cards.contains?(deck, "Ace of Spades")
    true
    iex> Cards.contains?(deck, "Mystery Card")
    false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck. The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

    iex> deck = Cards.create_deck
    iex> {hand, _deck} = Cards.deal(deck, 1)
    iex> hand
    ["Ace of Spades"]
  """
  def deal(deck, number) do
    Enum.split(deck, number)
  end

  @doc """
    Saves deck to a file
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write!(filename, binary)
  end

  @doc """
    Loads deck from stored deck
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
    Creates a deck shuffles and deals
  """
  def create_hand(size) do
    create_deck()
    |> shuffle()
    |> deal(size)
  end
end
