# Afinn

[![Elixir CI](https://github.com/kupolak/afinn/actions/workflows/elixir.yml/badge.svg?branch=master)](https://github.com/kupolak/afinn/actions/workflows/elixir.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/afinn.svg)](https://hex.pm/packages/afinn)
[![Documentation](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/afinn)

**Sentiment analysis library for Elixir** based on the AFINN word list. Fast, simple, and effective for analyzing the emotional tone of text.

The library is highly influenced by other `afinn` implementations and uses the well-established AFINN lexicon for sentiment scoring.

## Features

- 🚀 **Fast and lightweight** - Minimal dependencies, optimized for performance
- 🌍 **Multi-language support** - English 🇬🇧 and Danish 🇩🇰
- 📊 **Numeric scoring** - Get sentiment scores from -5 (very negative) to +5 (very positive)
- 📝 **Word classification** - Convert scores to human-readable categories (positive, negative, neutral)
- 🔧 **Simple API** - Easy to integrate into any Elixir project

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
    {:afinn, "~> 0.2.1"}
  ]
end
```

## Usage

### Supported Languages

| Language | Symbol | Dictionary Size |
|----------|--------|-----------------|
| English  | `:en`  | 2,477 words     |
| Danish   | `:dk`  | 3,693 words     |

### Basic Examples

```elixir
# English sentiment analysis
text = "I love this!"

Afinn.score(text, :en)
#=> 3

Afinn.score_to_words(text, :en)
#=> :positive

# Danish sentiment analysis
Afinn.score("Dårligt produkt!", :dk)
#=> -3

Afinn.score_to_words("Dårligt produkt!", :dk)
#=> :negative
```

### Advanced Usage

```elixir
# Analyzing mixed sentiment
mixed_text = "I love the design but hate the performance"
Afinn.score(mixed_text, :en)
#=> 1 (love: +3, hate: -3, overall slightly positive due to "love" weight)

# Neutral text
neutral_text = "This is a product"
Afinn.score_to_words(neutral_text, :en)
#=> :neutral

# Very positive text
Afinn.score("Awesome! Great! Excellent! Love it!", :en)
#=> 16

# Very negative text
Afinn.score("Terrible! Awful! Horrible! Hate it!", :en)
#=> -14
```

### Return Values

The `score_to_words/2` function returns:
- `:positive` - for scores > 0
- `:negative` - for scores < 0
- `:neutral` - for scores = 0

## Dictionaries

The AFINN lexicon is a list of words rated for valence with an integer between -5 (very negative) and +5 (very positive). The dictionaries used in this library are from the project by **Finn Årup Nielsen**.

### Resources

- **Dictionary source**: [AFINN Data on GitHub](https://github.com/fnielsen/afinn/tree/master/afinn/data)
- **Reference documentation**: [Corpus Text - AFINN Sentiment](http://corpustext.com/reference/sentiment_afinn.html)
- **Academic paper**: [A new ANEW: Evaluation of a word list for sentiment analysis in microblogs](http://www2.imm.dtu.dk/pubdb/views/edoc_download.php/6006/pdf/imm6006.pdf)

### How it Works

The library tokenizes input text and matches words against the AFINN dictionary. Each matched word contributes its sentiment score, and the total is summed to produce the final sentiment score. Words not in the dictionary contribute 0 to the score.

## Similar Libraries in Other Languages

| Language   | Repository | Description |
|------------|------------|-------------|
| Python     | [fnielsen/afinn](https://github.com/fnielsen/afinn) | Original AFINN implementation |
| JavaScript | [darenr/afinn](https://github.com/darenr/afinn) | AFINN for Node.js |
| Ruby       | [prograils/afinn](https://github.com/prograils/afinn) | AFINN for Ruby |

## API Reference

### `Afinn.score/2`

Returns the sentiment score for the given text.

```elixir
@spec score(String.t(), :en | :dk) :: integer()
```

**Parameters:**
- `text` - The text to analyze
- `language` - Language atom (`:en` for English, `:dk` for Danish)

**Returns:** Integer sentiment score

### `Afinn.score_to_words/2`

Returns a human-readable sentiment classification.

```elixir
@spec score_to_words(String.t(), :en | :dk) :: :positive | :negative | :neutral
```

**Parameters:**
- `text` - The text to analyze
- `language` - Language atom (`:en` for English, `:dk` for Danish)

**Returns:** Atom representing sentiment (`:positive`, `:negative`, or `:neutral`)

## Documentation

Full documentation is available on [HexDocs](https://hexdocs.pm/afinn).

To generate documentation locally:

```bash
mix docs
```

## Requirements

- Elixir 1.14 or higher
- Erlang/OTP 25 or higher

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup

```bash
# Clone the repository
git clone https://github.com/kupolak/afinn.git
cd afinn

# Install dependencies
mix deps.get

# Run tests
mix test

# Run code formatter
mix format

# Run linter
mix credo --strict
```

### Guidelines

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is available as open source. See the LICENSE file for more info.

## Credits

- **AFINN word list**: Created by Finn Årup Nielsen
- **Library maintainer**: [@kupolak](https://github.com/kupolak)

---

**Note**: Sentiment analysis using word lists like AFINN is best suited for short texts like tweets, reviews, and comments. For more complex sentiment analysis tasks, consider using machine learning-based approaches.