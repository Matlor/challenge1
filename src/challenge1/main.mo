import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
actor {
    public func add(n : Nat, m: Nat) : async Nat {
        return n + m;
    };

    public func square(n : Nat) : async Nat {
        return Nat.pow(n,n);
    };


    public func days_to_second(n : Nat) : async Nat {
        return n*24*60*60;
    };


    var counter: Nat = 0;
    public func increment_counter(n : Nat) : async Nat {
        counter+= n;
        return counter;
    };

    public func clear_counter() : async Nat {
        counter:=0;
        return counter;
    };
    
     public func divide(n : Nat, m: Nat) : async Bool {
        let mod: Nat = n%m;
        if(mod == 0){
            return true;
        } else {
            return false;
        }
    };


      public func is_even(n : Nat) : async Bool {
        let mod: Nat = n%2;
        if(mod == 0){
            return true;
        } else {
            return false;
        }
    };





      public func sum_of_array(n : [Nat]) : async Nat {
        
        if(n.size() == 0){
            return 0;
        } else {
            var sum: Nat = 0;
            for(i in Iter.range(0, n.size())){
                sum += i;
            };

            return sum;
        }
    };



    public func maximum(n : [Nat]) : async Nat {
        
        var test = n.size();
        Debug.print(debug_show(test));
        if(n.size() == 0){
            return 0;
        } else {
            var max: Nat = 0;
         
            for(i in Iter.range(0, n.size()-1)){
                Debug.print(debug_show(i));
                if(n[i] >= max){
                    max:=n[i];
                };
            }; 
            return max;
        };
    };


    public func remove_from_array(myArray : [Nat], n:Nat) : async [Nat] {

        func filterArray(item: Nat):Bool{
            if(item != n){
                return true;
            } else {
                return false;
            };
        };

        let newArray: [Nat] = Array.filter(myArray, filterArray);
        return newArray;
    };
    
    public func selection_sort(myArray : [Nat]) : async [Nat] {
        let newArray: [Nat] = Array.sort(myArray, Nat.compare);
        return newArray;
    };


};
