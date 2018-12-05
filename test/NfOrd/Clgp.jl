@testset "Clgp" begin

  @testset "class_group" begin
     Qx, x = PolynomialRing(FlintQQ, "x");

    @testset "K = Q" begin # TODO Fix class_group for K = Q
      #= K, a = NumberField(x, "a"); =#
      #= O = maximal_order(K) =#
      #= Cl = Hecke.class_group(O); =#
      #= @test Cl.h == 1 =#
    end

    @testset "class numbers" begin

      @testset "quadratic fields" begin
        classnumbersofquadraticfields = [(-50,1),(-49,1),(-48,1),(-47,5),(-46,4)
          ,(-45,2),(-44,1),(-43,1),(-42,4),(-41,8),(-40,2),(-39,4),(-38,6)
          ,(-37,2),(-36,1),(-35,2),(-34,4),(-33,4),(-32,1),(-31,3),(-30,4)
          ,(-29,6),(-28,1),(-27,1),(-26,6),(-25,1),(-24,2),(-23,3),(-22,2)
          ,(-21,4),(-20,2),(-19,1),(-18,1),(-17,4),(-16,1),(-15,2),(-14,4)
          ,(-13,2),(-12,1),(-11,1),(-10,2),(-9,1),(-8,1),(-7,1),(-6,2),(-5,2)
          ,(-4,1),(-3,1),(-2,1),(-1,1),(2,1),(3,1),(5,1),(6,1),(7,1),(8,1)
          ,(10,2),(11,1),(12,1),(13,1),(14,1),(15,2),(17,1),(18,1),(19,1),(20,1)
          ,(21,1),(22,1),(23,1),(24,1),(26,2),(27,1),(28,1),(29,1),(30,2),(31,1)
          ,(32,1),(33,1),(34,2),(35,2),(37,1),(38,1),(39,2),(40,2),(41,1),(42,2)
          ,(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(50,1)]

        @testset "K = Q[√$d]" for (d,h) in classnumbersofquadraticfields
           K, a = NumberField(x^2-d, "a")
          O = maximal_order(K)
          Cl, mCl = Hecke.class_group(O, redo = true)
          U, mU = Hecke.unit_group(O)
          @test order(Cl) == h
        end
      end

      @testset "x^3-3*x-1" begin
        f = x^3 - 3*x - 1
         K, a = NumberField(f, "a");
        O = maximal_order(K)
        Cl, mCl = Hecke.class_group(O, redo = true);
        U, mU = Hecke.unit_group(O)
        @test order(Cl) == 1
      end

      @testset "29th cyclotomic polynomial" begin
        #= phi29 = x^28+x^27+x^26+x^25+x^24+x^23+x^22+x^21+x^20+x^19+x^18+x^17+x^16+x^15+x^14+x^13+x^12+x^11+x^10+x^9+x^8+x^7+x^6+x^5+x^4+x^3+x^2+x+1 =#
        #= K, a = NumberField(phi29, "a"); =#
        #= O = maximal_order(K) =#
        #= Cl = Hecke.class_group(O); =#
        #= @test Cl.h == 8 =#
      end


      @testset "53th cyclotomic polynomial" begin
        #= phi53 = x^52+x^51+x^50+x^49+x^48+x^47+x^46+x^45+x^44+x^43+x^42+x^41+x^40+x^39+x^38+x^37+x^36+x^35+x^34+x^33+x^32+x^31+x^30+x^29+x^28+x^27+x^26+x^25+x^24+x^23+x^22+x^21+x^20+x^19+x^18+x^17+x^16+x^15+x^14+x^13+x^12+x^11+x^10+x^9+x^8+x^7+x^6+x^5+x^4+x^3+x^2+x+1 =#
        #= K, a = NumberField(phi53, "a"); =#
        #= O = maximal_order(K) =#
        #= Cl = Hecke.class_group(O); =#
        #= @test Cl.h == 4889 =#
      end

      @testset "121th cyclotomic polynomial" begin
        #= phi121 = x^110+x^99+x^88+x^77+x^66+x^55+x^44+x^33+x^22+x^11+1 =#
        #= K, a = NumberField(phi121, "a"); =#
        #= O = maximal_order(K) =#
        #= Cl = Hecke.class_group(O); =#
        #= @test Cl.h == 12188792628211 =#
      end

    end

  end

  @testset "_class_unit_group" begin
     Qx, x = PolynomialRing(FlintQQ, "x");
    AF = ArbField(20)

    @testset "K = Q" begin # TODO Fix _class_unit_group for K = Q
      #= K, a = NumberField(x, "a"); =#
      #= O = maximal_order(K) =#
      #= Cl, U, b = Hecke._class_unit_group(O); =#
      #= @test b == 1 =#
      #= @test U.order == O =#
      #= @test U.torsion_units_order == 2 =#
      #= @test 1 in U.torsion_units =#
      #= @test -1 in U.torsion_units =#
      #= @test contains(AF(1),U.tentative_regulator) =#
    end

    @testset "K = Q[√2]" begin
       K, a = NumberField(x^2-2, "a");
      O = maximal_order(K)

      Cl, mCl = Hecke.class_group(O, redo = true);
      UU, mU = Hecke.unit_group(O)

      U = Hecke._get_UnitGrpCtx_of_order(O)

      G, mG = torsion_unit_group(O)
      @test order(G) == 2
      @test mG(G[1]) == O(-1)
      @test order(U) == O
      @test U.torsion_units_order == 2
      #@test 1 in U.torsion_units
      #@test -1 in U.torsion_units
      @test contains(AF(0.88137358701),U.tentative_regulator)
      @test order(Cl) == 1
    end

    @testset "K = Q[x]/(f), f = x^3 - 2" begin
       K, a = NumberField(x^2 - 3, "a");
      O = maximal_order(K);
      Cl, mCl = Hecke.class_group(O, redo = true);
      UU, mU = Hecke.unit_group(O)

      @test order(Cl) == 1
    end

    @testset "f = Q[x]/(f), f = x^5 - 11^2 * 7" begin
       K, a = NumberField(x^5 - 11^2 * 7, "a");
      O = maximal_order(K)
      Cl, mCl = Hecke.class_group(O, redo = true);
      UU, mU = Hecke.unit_group(O)

      U = Hecke._get_UnitGrpCtx_of_order(O)

      G, mG = torsion_unit_group(O)
      @test order(G) == 2
      @test mG(G[1]) == O(-1)
      @test order(U) == O
      @test U.torsion_units_order == 2
      @test contains(AF(2027.9289425180057),U.tentative_regulator)
      @test order(Cl) == 5
    end
    
    @testset "Cyclotomic Field 13" begin
      K, a = cyclotomic_field(13);
      O = maximal_order(K)
      Cl, mCl = Hecke.class_group(O, redo = true);
      UU, mU = Hecke.unit_group(O)

      U = Hecke._get_UnitGrpCtx_of_order(O)

      G, mG = torsion_unit_group(O)
      @test order(G) == 26
      @test order(U) == O
      @test U.torsion_units_order == 26
      @test order(Cl) == 1
    end
    
    @testset "f = Q[x]/(f), f = x^18 + 18*x^16 + 135*x^14 + 192*x^12 - 2961*x^10 - 17334*x^8+ 20361*x^6 +  315108*x^4 + 514944*x^2 + 123904" begin
       K, a = NumberField(x^18 + 18*x^16 + 135*x^14 + 192*x^12 - 2961*x^10 - 17334*x^8+ 20361*x^6 +  315108*x^4 + 514944*x^2 + 123904, "a")
      O = maximal_order(K)

      Cl, mCl = Hecke.class_group(O, redo = true);
      UU, mU = Hecke.unit_group(O)

      @test order(Cl)== 36
    end

  end

end

