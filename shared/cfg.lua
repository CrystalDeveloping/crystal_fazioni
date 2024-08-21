Config = {}

Config.fazioni = {
    police = {
        job = 'police',
        blipenable = true,
        blip = 60,
        blipScale = 1.0,
        blipColor = 3,
        blipText = 'Stazione Di Polizia',
        blipcord = { -1097.8246, -830.4391, 37.7006},
        deposito1 = {-543.557, -972.230, 23.518},
        deposito2 = {-543.629, -974.808, 23.467},
        deposito3 = {-543.039, -983.490, 23.324},
        camerino = {-540.455, -975.455, 23.480},
        garage1 = {
            pos = {-539.854, -982.083, 23.362},
            spawn = {x = -540.013, y = -981.500, z = 23.364}, -- miraccomando utilizzate le coordinate così non mettete il vector3
            heading = 0,
            color = {rgb1 = 235, rgb2 = 235, rgb3 = 235},
            vehicles = {
                {label = 'Auto', model = 'faction'},
                {label = 'Moto', model = 'bf400'},
            },
        },
        garage_deposito = {-544.194, -989.876, 23.311},
        bossmenu = {-540.455, -975.455, 23.480}
    }
}
