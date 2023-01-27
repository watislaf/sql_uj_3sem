const SIZE_OF_GRID = 800;

const getColums = (data: any) => {
    const objectWithAllKeys = data
        .map((data: any) => {
            return Object.keys(data)
        })
        .reduce(
            (left: any, right: any) => {
                return {
                    ...left,
                    ...right
                }
            },
            {}
        )
    const amountOfKeys = Object.keys(objectWithAllKeys).length
    return Object.keys(objectWithAllKeys)
        .map(key => {
                return {
                    field: objectWithAllKeys[key],
                    headerName: objectWithAllKeys[key],
                    width: SIZE_OF_GRID / amountOfKeys
                }
            }
        )
}

export default getColums;
