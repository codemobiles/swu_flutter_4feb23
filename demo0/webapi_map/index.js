const express = require("express")
const app = express()

app.get("/", (req, res)=>{
    res.json({result: "1234"})
})

app.listen(3000, ()=> console.log("server is ready at port http://localhost:3000"))
