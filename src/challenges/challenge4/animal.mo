module {
    public type Animal = {
        specie: Text;
        energy: Nat;
    };

    // public function of module is still private in the actor
    public func animal_sleep(animal: Animal): Animal {
        let newAnimal = {
            specie = animal.specie;
            energy = animal.energy+ 10;
        };
        return newAnimal;
    };



};