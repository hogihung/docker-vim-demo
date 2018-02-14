require 'logger'
require 'timeout'

class Commander
attr :command, :arguments, :validator, :logger, :timeout_in_secs,
:calling_method

def initialize(command, validator, logger=nil, timeout=0, args=[])
@command          = command
@validator        = validator
@logger           = logger
@timeout_in_secs  = timeout
@arguments        = args
@calling_method   = caller_locations
end

def self.run(command, validator, logger, timeout, args=[])
new(command, validator, logger, timeout, args).run
end

def logger_msg
@logger.info { "Commander.run: Calling method -> #{calling_method[2]}" } if @logger
end

def run
cmd   = command + ' ' + arguments unless arguments.empty?
cmd ||= command
logger_msg

output = nil
begin
begin
Timeout::timeout(timeout_in_secs) do
output = %x(#{cmd} 2> /dev/null)
end
end
rescue Timeout::Error => e
output_error = {error: "#{e}, threshold of (#{timeout_in_secs}) exceeded"}
rescue Errno::ENOENT => e
output_error = {error: e}
rescue => e
@logger.warn { "run: Error encountered -> #{e}" }
output_error = {error: "Error encountered -> #{e}"}
end
return output_error if output_error && output_error.has_key?(:error)
parse_output(output)
end

def parse_output(output)
@logger.info { "Commmander#parse_output" } if @logger

return {error: 'no output to parse'} if output.nil? || output.empty?
parsed_output = output.split(/\n/)

return {error: 'unable to parse output'} unless parsed_output.is_a?(Array)
validate_output(parsed_output)
end

def validate_output(data)
@logger.info { "Commmander#validate_output" } if @logger
result = []
valid = false

data.each do |line|
valid = true if line.match(validator)
next if line.nil? || line.empty?
result << line
end
return {error: 'failed validation'} unless valid
@logger.info { "validate_output: execution successful, returning valid data structure" }
{ok: result}
end
end
