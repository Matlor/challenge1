import Animal "animal";
import Array "mo:base/Array";
import Custom "custom";
import List "mo:base/List";
import ListModule "list";


actor {
    
    

    let animal: Animal.Animal = {
        specie = "helix pomatia";
        energy = 19;
    };
        
    public func fun(): async Custom.City{
        let myCity: Custom.City = {
            population = 8;
            name = "Basel";
            country = "Switzerland";
        };
        return myCity;
    };

    public func create_animal_then_takes_a_break(specie: Text, energy: Nat): async Animal.Animal {
        let newAnimal = {
            specie;
            energy;
        };

        return Animal.animal_sleep(newAnimal);
    };


    let zoo: List.List<Animal.Animal> = List.nil<Animal.Animal>();
    

    public func push_animal(animal: Animal.Animal): async () {
        ignore List.push(animal, zoo);
    }; 

    public func get_animals():async [Animal.Animal] {
        List.toArray(zoo);
    }; 


    public func test_size(l:List.List<Nat>): async Nat {
        ListModule.size(l);
    };


    public func test_get(l: List.List<Nat>, n:Nat): async ?Nat{
        ListModule.get(l, n);

    };
    
    
    public func test_reverse(l: List.List<Nat>): async List.List<Nat> { 
        ListModule.reverse(l);
    };


};