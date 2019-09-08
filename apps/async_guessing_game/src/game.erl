-module(game).

-export([init/0]).
-export([start/0]).
-export([guessing/1]).

init() ->
  Pid = spawn_link(?MODULE, start, []),
  {ok, Pid}.

start() ->
  Number = generate_number(),
  guessing(Number).

guessing(N) ->
  io:format("Pid: ~w~n", [self()]),
  receive
    {guess, Guess} when N =:= Guess ->
      win();
    {guess, Guess} when N > Guess ->
      io:format("It is too big~n"),
      guessing(N);
    {guess, Guess} when N < Guess ->
      io:format("It is too small~n"),
      guessing(N)
  end.

win() ->
  io:format("You win!~n"),
  case io:fread("Would you like to play again? y/n", "~s") of
    {ok, ["y"]} ->
      Number = generate_number(),
      guessing(Number);
    _ -> io:format("Goodbye~n")
  end.

generate_number() ->
  Number = rand:uniform(100),
  io:format("Number: ~w~n", [Number]),
  Number.
