require 'spec_helper'

describe Page do
  it { should validate_presence_of :raw_title }
  it { should validate_presence_of :raw_body }
end