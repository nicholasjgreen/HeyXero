Promise = require("bluebird");
XeroConnection = require('./xero-connection');

module.exports = {

  doRequest: (contactName, description, unitAmount) ->
    new Promise((resolve, reject) ->
      # https://api.xero.com/api.xro/2.0/reports/BankSummary
      body = """
        <Invoices>
          <Invoice>
            <Type>ACCREC</Type>
            <Contact>
              <Name>#{contactName}</Name>
            </Contact>
            <LineItems>
              <LineItem>
                <Description>#{description}</Description>
                <UnitAmount>#{unitAmount}</UnitAmount>
              </LineItem>
            </LineItems>
          </Invoice>
        </Invoices>
      """
      XeroConnection().call 'POST', '/Invoices', body, (err, json) ->
        if(err)
          reject()
        else
          resolve(json)
    )

  createAnswer: (jsonResponse) ->
    console.log("Received: #{JSON.stringify(jsonResponse)}")

    # Filter and map to array of array
    cellRows = jsonResponse.Response.Reports.Report.Rows.Row.filter((row) -> row.RowType == "Section" && row.Rows.Row[0].RowType == "Row").map((row) -> row.Rows.Row[0].Cells.Cell)
    if (cellRows.length > 0)
      cellRows.map((cellRow) ->
        {
          # First cell's Value
          accountName: cellRow[0].Value
          # Last cell
          closingBalance: cellRow.slice(-1)[0].Value
        }
      )

  formatAnswer: (answer) ->
    formattedAnswer = "\n"
    answer.forEach((row) -> formattedAnswer = formattedAnswer + "#{row.accountName}: #{row.closingBalance}\n")
    formattedAnswer

}
