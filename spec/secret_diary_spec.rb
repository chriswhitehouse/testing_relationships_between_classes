require_relative '../lib/secret_diary'

### WARNING ###
# For the purposes of this exercise, you are testing after
# the code has been written. This means your tests are prone
# to false positives!
#
# Make sure your tests work by deleting the bodies of the
# methods in `secret_diary.rb`, like this:
#
# ```ruby
# def write(new_message)
# end
# ```
#
# If they fail, then you know your tests are working
# as expected.
### WARNING ###

RSpec.describe SecretDiary do
  context "when locked" do
    let(:diary) { double(:diary)}
    let(:secret_diary) { SecretDiary.new(diary)}
    let(:new_message) { "Something" }

    it 'refuses to be read' do
      expect(secret_diary.read).to eq "Go away!"
    end

    it 'refuses to be written' do
      expect(secret_diary.write(new_message)).to eq "Go away!"
    end
  end

  context "when unlocked" do
    let(:diary) { double(:diary, :read => "Read", :write => true)  }
    let(:secret_diary) { SecretDiary.new(diary)}
    let(:new_message) { "Something" }

    it 'accepts a double for read method' do
      expect(diary).to receive(:read)
      diary.read
    end

    it 'gets read' do
      secret_diary.unlock
      expect(secret_diary.read).to eq "Read"
    end

    it 'accepts a double for write method' do
      expect(diary).to receive(:write)
      diary.write(new_message)
    end

    it 'gets read' do
      secret_diary.unlock
      expect(secret_diary.write(new_message)).to eq nil
    end
  end
end
