<?xml version="1.0" encoding="utf-8"?>

<!-- this file: PurchaseRequestStatusLetter.xsl -->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
	<html>
		<head>
		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

				<br />
				<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->
				<table cellspacing="0" cellpadding="5" border="0">
                    <!-- customize presentation - nicomo - 2020-04-08 -->
					<tr>
                        <td>
                            @@introduction@@ 
							<xsl:if test="notification_data/purchase_request/author != ''">
								<xsl:value-of select="notification_data/purchase_request/author" />.
							</xsl:if>
							<em><xsl:value-of select="notification_data/purchase_request/title" /></em><br />
                        </td>
					</tr>
					<tr>
						<td>
							<xsl:choose >
								<xsl:when test="/notification_data/purchase_request/request_status='APPROVED'">
									@@approved@@ <xsl:value-of select="notification_data/purchase_request/poline_reference" />.
								</xsl:when>
								<xsl:otherwise>
									@@rejected@@
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
<!-- replaced original version
                        <td>@@introduction@@
							<xsl:choose >
								<xsl:when test="/notification_data/purchase_request/request_status='APPROVED'">
									@@approved@@ <xsl:value-of select="notification_data/purchase_request/poline_reference" />.
								</xsl:when>
								<xsl:otherwise>
									@@rejected@@: <xsl:value-of select="notification_data/purchase_request/reject_reason_desc" />.
								</xsl:otherwise>
							</xsl:choose>
							<br />@@title@@: <xsl:value-of select="notification_data/purchase_request/title" />.
					</td>
				</tr>
-->
					
				</table>
				<br />
				<table>
						<tr><td>@@sincerely@@</td></tr>
						<tr><td>@@department@@</td></tr>
				</table>

				<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>