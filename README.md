# Raven::Processor::SanitizeSSN

This is a processor plugin for the [Sentry Raven client](https://github.com/getsentry/raven-ruby) that enables sanitizing Social Security numbers from data sent to Senty.

## Installation

    $ gem install raven-processor-sanitizessn

## Usage

Add this processor to the `processors` method of a Raven `config` block. You may also want to include Raven's default processor `Raven::Processor::SanitizeData`, or it will become disabled when you override the `processors` list.

```
Raven.configure do |config|
  config.processors = [Raven::Processor::SanitizeData, Raven::Processor::SanitizeSSN]
end
```

### Author

Matt Greensmith for [Cozy](http://www.cozy.co)

This processor is a modified version of the sanitizedata.rb processor from the sentry-raven gem. All source licensing applies.