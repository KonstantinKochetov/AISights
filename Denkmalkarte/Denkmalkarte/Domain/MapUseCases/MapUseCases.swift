protocol MapUseCases {

    func getMapData(success: @escaping (String) -> Void,
                    failure: @escaping (Error) -> Void)
}
