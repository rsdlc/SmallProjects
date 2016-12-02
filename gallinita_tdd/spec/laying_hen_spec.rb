require 'laying_hen'

describe LayingHen do
  let(:gallina) {LayingHen.new}
  let(:egg) {gallina.age!.age!.age!.age!.pick_an_egg!}
  # LayingHen tests here
  describe "#initalize" do
    context "with valid input" do
      it "creates new hen" do
        expect(gallina).to be_an_instance_of LayingHen
      end
    end

    context "with invalid input" do
      it "sends error message" do
        expect {LayingHen.new(8)}.to raise_error(ArgumentError)
      end
    end
  end

  describe "#age" do
    context "hen is not 3 months old" do
      it "lays no eggs" do
        expect(gallina.age!.any_eggs?).to eq(false)
      end
    end

    context "hen older than 3 months old" do
      it "lays eggs" do
        expect(gallina.age!.age!.age!.age!.any_eggs?).to eq(true)
      end
    end
  end

  describe "#any_eggs?" do
    context "hen has not laid any eggs" do
      it "returns false" do
        expect(gallina.any_eggs?).to eq(false)
      end
    end

    context "hen has laid eggs" do
      it "returns true" do
        expect(gallina.age!.age!.age!.age!.any_eggs?).to eq(true)
      end
    end
  end

  describe "#pick_an_egg!" do
    context "there are eggs" do
      it "returns an egg" do
        expect(gallina.age!.age!.age!.age!.pick_an_egg!).to be_an_instance_of Egg
      end
    end

    context "there are no eggs" do
      it "raises error" do
        expect {gallina.pick_an_egg!}.to raise_error(NoEggsError)
      end
    end
  end

  describe "#old?" do
    context "hen less than 10months old" do
      it "returns false" do
        expect(gallina.age!.age!.age!.age!.old?).to eq(false)
      end
    end

    context "hen older than 10months old" do
      it "returns true" do
        expect(gallina.age!.age!.age!.age!.age!.age!.age!.age!.age!.age!.age!.old?).to eq(true)
      end
    end
  end

  describe "#increase_hatched_hour" do
    context "increased hatched hours" do
      it "changes hatched hours" do
        expect { gallina.increase_hatched_hour(10) }.to change{gallina.age!.age!.age!.age!.pick_an_egg!.hatched_hours}.from(0).to(10)
      end
    end
  end




end

describe Egg do
  let(:gallina) {LayingHen.new}
  let(:egg) {gallina.age!.age!.age!.age!.pick_an_egg!}
  # Egg tests here
  describe "#initialize" do
    context "creating an egg with valid input" do
      it "creates egg" do
        expect(egg).to be_an_instance_of Egg
      end
    end

    context "creating an egg with invalid input" do
      it "does not create egg" do
        expect {Egg.new(5)}.to raise_error(ArgumentError)
      end
    end
  end

  describe "#rotten?" do
    context "hatched hours greater than 3" do
      it "returns true" do
        expect(gallina.age!.age!.age!.age!.increase_hatched_hour(5).pick_an_egg!.rotten?).to eq(true)
      end
    end

    context "hatched hours less than 3" do
      it "returns false" do
        expect(gallina.age!.age!.age!.age!.increase_hatched_hour(2).pick_an_egg!.rotten?).to eq(false)
      end
    end
  end


end


class NoEggsError < StandardError; end
