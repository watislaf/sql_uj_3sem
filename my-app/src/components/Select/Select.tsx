import {useParams} from "react-router-dom";
import {useEffect, useRef, useState} from "react";
import axios from "axios";
import {DataGrid} from '@mui/x-data-grid'
import getColums from "../../common/utils/Utils";
import {Box} from "@mui/material";

type UrlProps = {
    id: string
}

type Props = {
    setLoading: (value: boolean) => void;
}

const fetchData = (database: string | undefined, setData: (data: any) => void, onFetched: () => void) => {
    axios
        .get('http://localhost:3000/api/select/?databaseName=' + database || "students")
        .then((res) => {
            setData(res.data);
            onFetched();
        })
        .catch((err) => {
            console.log(err);
            onFetched();
        });
}

const Select = ({setLoading}: Props) => {
    const {id} = useParams<UrlProps>();
    const [data, setData] = useState(null);


    useEffect(() => {
        setLoading(true);
        fetchData(id, setData, () => setLoading(false));
    }, [id])

    if (!data) return <></>;

    return <div>
        <Box sx={{height: 400, width: '100%'}}>
            <DataGrid
                rows={data}
                columns={getColums(data)}
                pageSize={10}
                rowsPerPageOptions={[10]}
            />
        </Box>
    </div>
}

export default Select;
