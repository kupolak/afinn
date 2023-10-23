# Afinn

Sentiment analysis in Elixir.
The library is highly influenced by other `afinn` implementations.

Dictionaries included:
* English Language 🇬🇧

## Table of contents

- [Installation](#installation)
- [Usage](#usage)
- [Dictionaries](#dictionaries)
- [Similar libraries in other programming languages](#similar-libraries-in-other-programming-languages)
- [Documentation](#documentation)
- [Contributing](#contributing)

## Installation

The package can be installed
by adding `afinn` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:afinn, "~> 0.2.0"}
  ]
end
```

## Usage

```elixir
text = 'I love this!'

Afinn.score(text, :en)
#=> 3

Afinn.score_to_words(text, :en)
#=> :positive
```

## Dictionaries
The dictionaries used in this repository are from a project by Finn Årup Nielsen:
https://github.com/fnielsen/afinn/tree/master/afinn/data

For more information visit:
http://corpustext.com/reference/sentiment_afinn.html

Paper with supplement: http://www2.imm.dtu.dk/pubdb/views/edoc_download.php/6006/pdf/imm6006.pdf

## Similar libraries in other programming languages
* https://github.com/fnielsen/afinn - Sentiment analysis in Python with AFINN word list
* https://github.com/darenr/afinn - Sentiment analysis in Javascript with AFINN word list
* https://github.com/prograils/afinn - Sentiment analysis in Ruby with AFINN word list

## Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/afinn](https://hexdocs.pm/afinn).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kupolak/afinn.