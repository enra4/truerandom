# truerandom

api wrapper for random.org

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  truerandom:
    github: enra4/truerandom
```

## Usage

```crystal
require "truerandom"

API_KEY = ""
truerandom = Truerandom::Client.new API_KEY

truerandom.integers({
  "n" => 2,
  "min" => 0,
  "max" => 10
}) do |res|
  puts res[:data] # => ["4", "2"]
  # res[:data] is (sadly) always of type Array(String)
end

# or

res = truerandom.integers({
  "n" => 2,
  "min" => 0,
  "max" => 10
})
puts res[:data] # => ["4", "2"]
```

## Methods
The return of the basic methods will look something like this
```crystal
{
	data: ["4", "2"],
	completion_time: "2011-10-10 13:19:12Z",
	bits_used: 16,
	bits_left: 199984,
	requests_left: 9999,
	advisory_delay: 0
}
```
Signed methods will also include ``:hashed_api_key`` and ``:signature``
If you want to call on a signed method, simply call the same method with an extra argument that has the value ``true``.

Example:
```crystal
truerandom.integers({
  "n" => 2,
  "min" => 0,
  "max" => 10
}, true) do |res|
  puts res[:hashed_api_key] # => your wonderfully hashed api key
end
```

### __`.integers(options, [signed])`__
Generates true random integers within a user-defined range

#### `options`
- `options["n"]` - How many random values you want
- `options["min"]` - The minimal value of the random integer
- `options["max"]` - The maximum value of the random integer
- `options["replacement"]` - (defaults to ``true``)  - Specifies whether the generated integers can be duplicates
- `options["base"]` - (defaults to ``10``) - Specifies the base of the random integers. Values allowed are ``2``, ``8``,  ``10`` and ``16``

### __`.decimal_fractions(options, [signed])`__
Generates true random decimal fractions within a user-defined range

#### `options`
- `options["n"]` - How many random values you want
- `options["decimalPlaces"]` - The number of decimal places to use
- `options["replacement"]` - (defaults to ``true``)  - Specifies whether the generated integers can be duplicates

### __`.gaussians(options, [signed])`__
Generates true random numbers from a gaussian distribution

#### `options`
- `options["n"]` - How many random values you want
- `options["mean"]` - The distribution's mean
- `options["standardDeviation"]` - The distribution's standard deviation
- `options["significantDigits"]` - The number of significant digits to use

### __`.strings(options, [signed])`__
Generates true random strings

#### `options`
- `options["n"]` - How many random values you want
- `options["length"]` - The length of each string
- `options["characters"]` - A string that contains the set of characters that are allowed to occur in the random strings
- `options["replacement"]` - (defaults to ``true``)  - Specifies whether the generated integers can be duplicates


### __`.uuids(options, [signed])`__
Generates true random UUIDs

#### `options`
- `options["n"]` - How many random values you want

### __`.blobs(options, [signed])`__
Generates BLOBs containing true random data

#### `options`
- `options["n"]` - How many random values you want
- `options["size"]` - The size of each blob, measured in bits

### __`.usage`__
Returns information related to the usage of your api key

#### contains
- `:status` - Current status
- `:creation_time` - When your api key was created
- `:bits_left` - Number of remaining true random bits available to the client
- `:requests_left` - Number of requests left available to the client
- `:total_bits` - Number of bits used by the api key since creation
- `:total_requests` - Number of requests used by the api key since creation

## Other
You could check out the tests for examples, also see https://api.random.org/json-rpc/1/ for more information
