%%%-------------------------------------------------------------------
%% @doc async_guessing_game public API
%% @end
%%%-------------------------------------------------------------------

-module(async_guessing_game_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    async_guessing_game_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
