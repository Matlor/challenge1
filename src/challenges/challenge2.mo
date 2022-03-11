import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Blob "mo:base/Blob";
import Array "mo:base/Array";


actor {
   
    public func nat_to_nat8(n : Nat) : async Nat8 { 
        Nat8.fromNat(n);
    };

    public func max_number_with_n_bits(n : Nat) : async Nat { 
        Nat.pow(2,n)-1;
    };
    
    public func decimal_to_bits(n : Nat) : async Text { 
        var result: Text = "";
        var num: Nat = n;

        while (num > 0){
            result:= Nat.toText(num % 2) # result;
            num:= num / 2;
        };

        return result;
    };

    public func capitalize_character(c : Char) : async Char { 
        var numb: Nat32= Char.toNat32(c);
        if (numb>=97 and numb<=122) {
            numb :=numb-32;
        };

        let newChar: Char =Char.fromNat32(numb);

        return newChar;
    };

    public func capitalize_text(t : Text) : async Text { 
        var newText:Text = "";

        for(i in t.chars()){
            var capitalChar = await capitalize_character(i);
            newText := Char.toText(capitalChar) # "";
        };
        return newText;
    };

    public func is_inside(t : Text, c:Char) : async Bool { 
    
        var isIn: Bool = false;
        for(i in t.chars()){
            if(i == c){
                isIn := true;
            };
        };

        return isIn;
    };


    public func trim_whitespace(t : Text) : async Text { 

        let pattern: Text.Pattern = #text(" ");
        let newText: Text = Text.trim(t, pattern);
        
        return newText;
    };




    public func duplicated_character(t : Text) : async Text { 

        for (char in t.chars()){

            var count = 0;
            for (comparedChar in t.chars()){
                if(char==comparedChar){
                    count +=1;
                    
                };
                if(count==2){
                    return Text.fromChar(char);
                };
            };
        };
        return  t; 
    };
        
    public func size_in_bytes(t : Text) : async Nat { 

       
        let b : Blob = Text.encodeUtf8(t);
        let array: [Nat8] = Blob.toArray(b);
        let i = Array.vals(array);

        var count =0;
        for(x in i){
             count +=1;
        };
        return  count; 
    };


    // to do
    public func bubble_sort(arr : [Nat]) : async () { 

    };

    

        

};



